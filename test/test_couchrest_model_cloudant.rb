require 'helper'

# fixture
class DesignModel < CouchRest::Model::Base
  property :email
end

class TestCouchrestModelCloudant < Test::Unit::TestCase

  should "should add the #index method to a design document" do
    @klass = CouchRest::Model::Designs::DesignMapper
    @object = @klass.new(DesignModel)
    @object.index(:important, 'function(doc){ index("email", doc._id); }')
    assert_not_nil DesignModel.design_doc['indexes']
    assert_not_equal DesignModel.design_doc['indexes'], []
    assert_not_equal DesignModel.design_doc['indexes'], ''
  end

  should "add the search method to a model class" do
    assert_respond_to DesignModel, :search
  end

  should "add the search method to the model's database class" do
    assert_respond_to DesignModel.database, :search
  end
end
