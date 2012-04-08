authorization do
  role :admin do
    has_permission_on [:patients, :payments,:users,:drugs,:tests,:diagnosis,:treatments], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  role :guest do
    has_permission_on :patients, :to => [:show]
    has_permission_on :drugs, :to => [:index]
    #has_permission_on :comments, :to => [:edit, :update] do
    #  if_attribute :user => is { user }
    #end
  end

  role :receptionist do
   # includes :guest
    has_permission_on :patients, :to => [:edit, :update,:index,:show]
  end

  role :labtech do
    includes :receptionist
    has_permission_on :performedtests, :to => [:new, :create,:update]
    #has_permission_on :articles, :to => [:edit, :update] do
    #  if_attribute :user => is { user }
    #end
  end
  role :cashier do
    includes :receptionist
    has_permission_on :payments, :to => [:new, :create,:update]
    has_permission_on :drugs, :to => [:new, :create,:update]
    #has_permission_on :articles, :to => [:edit, :update] do
    #  if_attribute :user => is { user }
    #end
  end
  role :consultant do
    includes :labtech
    has_permission_on :diagnosis, :to => [:new, :create,:update]
    has_permission_on :treatments, :to => [:new,:create, :update]
    #  if_attribute :user => is { user }
    #end
  end
end