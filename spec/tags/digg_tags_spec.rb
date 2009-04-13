require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'ostruct'


describe "The digg radiant tags" do

  class TestObject
    include Radiant::Taggable    
    include DiggTags
  end

  class TestStory
    def story=(story)
      @story = story
    puts @story
    end
  end
  
  
  before(:each) do
    @test_obj = TestObject.new
    @test_story = TestStory.new
    @tag_binding = OpenStruct.new('attr' => {"category" => ""}, 'locals' => @test_story )
  end
 
  it "should return the list of stories in a category" do
     @test_obj.should respond_to(:render_tag)
    # @test_obj.render_tag('digg:each', @tag_binding)   
    puts @test_obj.render_tag("digg:each",@tag_binding).methods.join("\n")
  end
  
 
  


end




















