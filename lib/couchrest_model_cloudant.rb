require 'couchrest_model'

######## CLOUDANT INDEX HANDLING ########
class CouchRest::Model::Design
  def create_index(name, function)
    indexes = (self['indexes'] ||= {})
    indexes[name.to_s] = function
  end
end

class CouchRest::Model::Designs::DesignMapper
  def index(name, function)
    design_doc.create_index(name, function)
  end
end

######## CLOUDANT SEARCH QUERYING ######
class CouchRest::Database
  def search(design, index, query, options={})
    CouchRest.get CouchRest.paramify_url("#{@root}/_design/#{design}/_search/#{index}", options.merge(:q => query))
  end
end

class CouchRest::Model::SearchResults
  include Enumerable

  attr_accessor :total_rows, :bookmark

  def initialize(total_rows, bookmark, objects)
    @total_rows = total_rows
    @bookmark = bookmark
    @objects = objects
  end

  def each
    @objects.each do |member|
      yield member
    end
  end
end

# 
# Execute a cloudant search query.
# if you are not using the :include_docs option then your indexes must be named to
# match document properties otherwise they cannot be casted into document models.  
#
class CouchRest::Model::Base
  def self.search(index, query, options={})
    convert_sort_query!(options)
    ret = self.database.search(self.to_s, index, query, options)
    rows = ret['rows']
     if options[:include_docs] == true || options['include_docs'] == true
      objects = rows.map {|r| klass = r['doc']['type']; obj = Object.const_get(klass).new(r['doc']) }
    else
      objects = rows.map {|r| obj = self.new(r['fields']); obj.id = r['id']; obj }
    end
    CouchRest::Model::SearchResults.new(ret['total_rows'], ret['bookmark'], objects)
  end

  # Cloudant has different funky quote syntax depending on if you're sorting by a single key or multiple keys
  # so this method makes sure you can specify either by specifying a ruby string or a ruby array of strings.  
  # Both symbols and strings are supported
  def self.convert_sort_query!(options)
    if options['sort']
      options[:sort] = options['sort']
      options['sort'] = nil
    end
    if options[:sort]
      if options[:sort].class == String
        options[:sort] = '"' + options[:sort] + '"'
      else options[:sort].class == Array
        arr = options[:sort]
        options[:sort] = '['
        arr.each do |a|
          options[:sort] += '"' 
          options[:sort] += a
          options[:sort] += '"' 
          unless a == arr.last
              options[:sort] += ","
          end
        end
        options[:sort] += ']'
      end
    end
  end
end