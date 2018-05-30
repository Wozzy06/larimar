require "./spec_helper"

describe Larimar do
  props = Larimar::Properties.new

  it "should add a well parsed line and fetch data in memory" do
    props.parse("test=hello")
    props.parse("test.azerty=world")
    props.parse("qwerty.mayonnaise=cornichon")
    props.size.should eq 3
    props.get("test").should eq "hello"
    props.get("test.azerty").should eq "world"
    props.get("qwerty.mayonnaise").should eq "cornichon"
  end

  it "should fetch data in memory or if not exist default value" do
    props.get("test").should eq "hello"
    props.get("blahblah", "abcde").should eq "abcde"
  end

  it "should assert wether a key exists or not" do
    props.exists?("qwerty.mayonnaise").should eq true
  end

  it "should delete an existing key" do
    props.delete("qwerty.mayonnaise")
    props.size.should eq 2
  end

  it "should reset data in memory" do
    props.flush
    props.size.should eq 0
  end

  it "should not do anything when the line is wrong or commented" do
    props.parse("dejdeldeev")
    props.parse("=1rdjnf")
    props.parse("#ceci.est.un.commentaire=this is a comment")
    props.size.should eq 0

    props.flush
  end

  it "should read and load a file and skip wrong/commented line" do
    props.load("./spec/test.properties")
    props.size.should eq 4
    props.flush
  end

  it "should raise an error when trying to fetch inexistant data (missing or mispelled)" do
    expect_raises(Larimar::UnknownPropertyException) do
      props.get("çanevapasmarcher")
    end
  end
end
