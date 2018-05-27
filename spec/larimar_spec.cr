require "./spec_helper"

describe Larimar do
  it "should add a well parsed line and fetch data in memory" do
    Larimar.parse("test=hello")
    Larimar.parse("test.azerty=world")
    Larimar.parse("qwerty.mayonnaise=cornichon")
    Larimar::DATA.size.should eq 3
    Larimar.get("test").should eq "hello"
    Larimar.get("test.azerty").should eq "world"
    Larimar.get("qwerty.mayonnaise").should eq "cornichon"
  end

  it "should reset data in memory" do
    Larimar.flush
    Larimar::DATA.size.should eq 0
  end

  it "should not do anything when the line is wrong or commented" do
    Larimar.parse("dejdeldeev")
    Larimar.parse("=1rdjnf")
    Larimar.parse("#ceci.est.un.commentaire=this is a comment")
    Larimar::DATA.size.should eq 0

    Larimar.flush
  end

  it "should read and load a file and skip wrong/commented line" do
    Larimar.load("./spec/test.properties")
    Larimar::DATA.size.should eq 4
    Larimar.flush
  end

  it "should raise an error when trying to fetch inexistant data (missing or mispelled)" do
    expect_raises(Exception) do
      Larimar.get("çanevapasmarcher")
    end
  end
end
