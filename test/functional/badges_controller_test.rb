require File.join(File.dirname(__FILE__), '..', 'test_helper')

class BadgesControllerTest < ActionController::TestCase
  
  context 'GET to index' do
    setup { get :index }
    
    should_respond_with :success
    should_assign_to :badges
  end
  
  context 'GET to new' do
     setup { get :new }

     should_respond_with :success
     should_render_template :new
     should_assign_to :badge
   end

   context 'POST to create' do
     setup do
       post :create, :badge => Factory.attributes_for(:badge)
       @badge = Badge.last
     end

     should_change 'Badge.count', :by => 1
     should_set_the_flash_to /created/i
     should_redirect_to('badge show') {badge_path(@badge)}

   end

   context 'GET to show' do
     setup do
       @badge = Factory(:badge)
       get :show, :id => @badge.to_param
     end

     should_respond_with :success
     should_render_template :show
     should_assign_to :badge
   end

  context 'GET to edit' do
    setup do
      @badge = Factory(:badge) }
      get :edit, :id => @badge.to_param }
    end
      
    should_respond_with :success
  end

    context 'PUT to update' do
      setup do
        @badge = Factory(:badge) 
        setup { put :update, :id => @badge.to_param, :project => Factory.attributes_for(:badge) }
      end
      
       should_respond_with :success
       should_set_the_flash_to /updated/i
       should_assign_to(:badge) { @badge }
       should_redirect_to('badge show') {badge_path(@badge)}               
     end
   end

   context 'given a badge exists' do
     setup do
      @badge = Factory(:badge) 
      delete :destroy, :id => @badge.to_param}
      end
      
      should_process_badge_deletions
   end

   def self.should_process_badge_deletions
     should_change 'Badge.count', :by => -1
     should_set_the_flash_to /deleted/i
     should_redirect_to('badges index') {badges_path}
   end
   
end
