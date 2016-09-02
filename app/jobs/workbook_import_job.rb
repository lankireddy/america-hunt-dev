class WorkbookImportJob < ActiveJob::Base
  queue_as :default

  TOP_LEVEL_NAMES = ['Big Game', 'Upland Birds', 'Small Game', 'Game Bird', 'Waterfowl', 'Exotic Game']


  def perform(*args)
    require 'roo'
  #America Hunt Destinations.xlsx
    xlsx = Roo::Spreadsheet.open("#{Rails.root}/app/assets/imports/#{args[0]}")
    xlsx.default_sheet = xlsx.sheets[args[1]] if(args.length > 1)
    row_start = 2
    row_start = args[2] if(args.length > 2)

    row_stop = xlsx.last_row
    col_stop = xlsx.last_column
    species_column_hash = {
      18 => Species.find_or_create_by(name: 'Big Game').children,
      19 => Species.find_or_create_by(name: 'Upland Birds').children,
      20 => Species.find_or_create_by(name: 'Small Game').children,
      21 => Species.find_or_create_by(name: 'Game Bird').children,
      22 => Species.find_or_create_by(name: 'Waterfowl').children,
      23 => Species.find_or_create_by(name: 'Exotic Game').children
    }

    (row_start..row_stop).each do |row_index|
      row_data = (1..col_stop).collect { |column_index| xlsx.cell(row_index,column_index) }
      location = Location.new
      location.status = 'approved' if row_data[0] == 'Approved'
      location.author = AdminUser.find_by(name: row_data[2].try(:strip))
      location.name = row_data[3]
      if(row_data[4].present?)
        location.website =row_data[4].strip
        location.website = 'http://' + location.website unless URI.parse(location.website) && URI.parse(location.website).scheme
      end
      if(row_data[5].present?)
        location.contact_page = row_data[5].strip
        location.contact_page = 'http://' + location.contact_page unless URI.parse(location.contact_page) && URI.parse(location.contact_page).scheme
      end
      location.phone = row_data[6]
      location.email = row_data[7]
      location.address_1 = row_data[8]
      location.city = row_data[9]
      location.state = row_data[10]
      location.zip = row_data[11]
      location.description = row_data[14]
      location.handicap_status = 'handicap_accessible' if(row_data[15]=='Yes' || row_data[15]=='handicap_accessible')
      #location.child_status = 'children_not_allowed' if(row_data[16]=='No')
      #location.pet_status = 'pet_no' if(row_data[17]=='No')
      species_column_hash.each { |index, species| location.species << match_species(species, row_data[index]) if row_data[index].present? }
      if row_data[24].present?
        row_data[24].gsub(/ and /i, ',').gsub(/ or /i, ',').split(',').map(&:strip).reject(&:empty?).map(&:capitalize).each do |type|
          location.categories << Category.find_or_create_by(name: type)
        end
      end
      if row_data[25].present?
        row_data[25].gsub(/ and /i, ',').gsub(/ or /i, ',').split(',').map(&:strip).reject(&:empty?).map(&:titleize).map(&:singularize).each do |type|
          location.weapon_types << WeaponType.find_or_create_by(name: type)
        end
      end
      location.submitter_notes = [row_data[27], row_data[28]].reject(&:nil?).join(' | ')
      if(location.save)
        puts "   Row ##{row_index} saved"
      elsif(location.errors.full_messages=='invalid species')
        location.species.select{ |species| id==nil }.each do |species|
          location.species << Species.find_by(name: species.name)
          location.species.delete(species)
        end
        if(location.save)
          puts "   Row ##{row_index} saved with corrected species"
        else
          puts "Row ##{row_index} failed to save: #{location.errors.full_messages}"
          binding.pry
        end
      end
    end
  end

  def match_species(child_categories, species_list_cell)
    species = []
    species_names = species_list_cell.gsub(/ and /i, ",").gsub('.',' ').split(',').map(&:strip).reject(&:empty?).map(&:capitalize)
    species_names.each do |species_name|
      species_name = 'Other ' + species_name if TOP_LEVEL_NAMES.include?(species_name)
      species << child_categories.find_or_create_by(name: species_name)
    end
    species
  end
end
