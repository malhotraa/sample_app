require 'spec_helper'

describe "MicropostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "test for correct microposts count" do
    before { visit root_path }
    
    describe "should show 1 micropost" do
      before do
        fill_in 'micropost_content', with: "Lorem ipsum"
        click_button "Post"
      end
      it { should have_content('1 micropost') }
      it { should_not have_content('microposts') }
    end
    
    describe "should show 3 microposts" do
      before do
        fill_in 'micropost_content', with: "Lorem ipsum"
        click_button "Post"
        fill_in 'micropost_content', with: "Lorem ipsum"
        click_button "Post"
        fill_in 'micropost_content', with: "Lorem ipsum"
        click_button "Post"
      end
      it { should have_content('3 microposts') }
      it { should_not have_content(/micropost/) }
    end
  end
  
  describe "micropost creation" do
    before { visit root_path }
    
    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.should_not change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.should change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }
      
    describe "as correct user" do
      before { visit root_path }
          
      it "should delete a micropost" do
        expect { click_link "delete" }.should change(Micropost, :count).by(-1)
      end
    end
  end
end
