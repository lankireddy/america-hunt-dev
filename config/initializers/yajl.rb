# This replaces MultiJSON's backend with YAJL, a much faster
# JSON serializer than the default JSON gem
require 'multi_json'
MultiJson.use :yajl
