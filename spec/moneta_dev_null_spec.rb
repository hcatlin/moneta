require File.dirname(__FILE__) + '/spec_helper'

begin
  require "moneta/dev_null"
  
  describe "Moneta::DevNull" do
    before(:each) do
      @cache = Moneta::DevNull.new
    end
    
    it "reads from keys like an empty Hash" do
      @cache["key"].should == nil
    end

    it "doesn't write to a key like a Hash" do
      @cache["key"] = "value"
      @cache["key"].should == nil
    end

    it "specifies that it is writable via frozen?" do
      @cache.should_not be_frozen
    end

    it "if a key is not available, returns false from key?" do
      @cache.key?("key").should be_false
    end

    it "if a key is available, still gives back false" do
      @cache["key"] = "value"
      @cache.key?("key").should be_false
    end

    it "if it should exist, return nil" do
      @cache["key"] = "value"
      @cache.delete("key").should == nil
      @cache.key?("key").should be_false
    end

    it "if it does not exists, returns nil from delete" do
      @cache.delete("key").should be_nil
    end

    it "fetches a key with a default value with fetch, if the key is not available" do
      @cache.fetch("key", "value").should == "value"
      @cache["key"].should == nil
    end

    it "fetches a key with a block with fetch, if the key is not available" do
      @cache.fetch("key") { |key| "value" }.should == "value"
    end

    it "unsuccessfully stores values with #store" do
      @cache.store("key", "value")
      @cache["key"].should == nil
    end
    
    it "should accept the expires key" do
      @cache.store("key", "value", :expires_in => 1)
    end
  end
rescue SystemExit
end