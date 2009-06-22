require File.join(File.dirname(__FILE__), '..', 'test_helper')

class BadgesControllerTest < ActionController::TestCase
  
  context 'GET to index' do
    setup { get :index }
    
    should_respond_with :success
    should_assign_to :badges
  end
  
  context "GET new" do
    admin_user do
      setup { get :new }
      
      should_respond_with :success
      should_render_template :new
      should_assign_to :badge
    end
    
    context "not as admin user" do
      setup { get :new }
      
      should_respond_with 302
      should_redirect_to('login') { login_path }
    end
  end

   context 'POST to create' do
     
     admin_user do
      setup do
        post :create, :badge => Factory.attributes_for(:badge)
        @badge = Badge.last
      end
      
      should_change 'Badge.count', :by => 1
      should_set_the_flash_to /created/i
      should_redirect_to('badge show') {badge_path(@badge)}
    end
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
    
    admin_user do
      setup do
        @badge = Factory(:badge) 
        get :edit, :id => @badge.to_param
      end
        
      should_respond_with :success
      end
  end

  context 'PUT to update' do
    admin_user do
      setup do
        @badge = Factory(:badge) 
        put :update, :id => @badge.to_param, :project => Factory.attributes_for(:badge)
      end
        
      should_set_the_flash_to /updated/i
      should_assign_to(:badge) { @badge }
      should_redirect_to('badge show') {badge_path(@badge)}
    end
  end
  
  def self.should_process_badge_deletions
    should_change 'Badge.count', :by => -1
    should_set_the_flash_to /Badge was deleted./i
    should_redirect_to('badges index') {badges_path}
  end
  
  context 'given a badge exists' do
    setup { @badge = Factory(:badge) }

    context 'DELETE to destroy' do
      
      admin_user do
        context 'with admin access' do
          setup { delete :destroy, :id => @badge.to_param}
          should_process_badge_deletions
        end
      end

    end
  end


end
