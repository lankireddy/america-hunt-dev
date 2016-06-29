shared_context 'with_token_authenticatable' do |proc|
  before do
    user = instance_eval(&proc)
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['HTTP_AUTHORIZATION'] = "Token token=#{user.authentication_token}, id=#{user.id}"
  end
end

def with_token_authenticatable(&block)
  include_context 'with_token_authenticatable', block
end
