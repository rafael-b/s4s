
#----------------------------------------------------------------------------- users
puts " -- users"
User.create( 
  :name                   => 'RSite Admin',
  :email                  => 'bugajski.r@gmail.com',
  :password               => 'fluffy',
  :password_confirmation  => 'fluffy',
  :role_id                => 4,
  :editable               => false,
  :deletable              => false
)
User.create( 
  :name                   => 'Rafael Bugajski',
  :email                  => 'bugajski.rafael@gmail.com',
  :password               => 'fluffy',
  :password_confirmation  => 'fluffy',
  :role_id                => 5
)
User.create( 
  :name                   => 'Student',
  :email                  => 'bugajski.rrr@gmail.com',
  :password               => 'fluffy',
  :password_confirmation  => 'fluffy',
  :role_id                => 3,
  :deletable              => false
)
User.create( 
  :name                   => 'Guest',
  :email                  => 'bugajski.rr@gmail.com',
  :password               => 'fluffy',
  :password_confirmation  => 'fluffy',
  :deletable              => false
)

#----------------------------------------------------------------------------- settings
puts " -- app_settings"
AppSetting.create 

#----------------------------------------------------------------------------- segments
puts " -- app_segments"
AppSegment.create(
  :code  => 'global',
  :name  => 'global',
  :title => 'Global',
  :description => "Scope: all"
)
AppSegment.create(
  :code  => 'web',
  :name  => 'web',
  :title => 'Web',
  :description => "Scope: home, blog, forum, store, school, auth, user"
)
AppSegment.create(
  :code  => 'home',
  :name  => 'home',
  :title => 'Home',
  :description => "Scope: home"
)
AppSegment.create(
  :code  => 'blog',
  :name  => 'blog',
  :title => 'Blog',
  :description => "Scope: blog"
)
AppSegment.create(
  :code  => 'forum',
  :name  => 'forum',
  :title => 'Forum',
  :description => "Scope: forum"
)
AppSegment.create(
  :code  => 'store',
  :name  => 'store',
  :title => 'Store',
  :description => "Scope: store"
)

AppSegment.create(
  :code  => 'school',
  :name  => 'school',
  :title => 'School',
  :description => "Scope: school"
)
AppSegment.create(
  :code  => 'auth',
  :name  => 'auth',
  :title => 'Auth',
  :description => "Scope: auth"
)
AppSegment.create(
  :code  => 'user',
  :name  => 'user',
  :title => 'User',
  :description => "Scope: user"
)
AppSegment.create(
  :code  => 'admin',
  :name  => 'admin',
  :title => 'Admin',
  :description => "Scope: admin"
)
AppSegment.create(
  :code  => 'override',
  :name  => 'override',
  :title => 'Override',
  :description => "Scope: all"
)
AppSegment.create(
  :code  => 'cond',
  :name  => 'cond',
  :title => 'Conditional',
  :description => "Scope: all"
)
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------

require File.expand_path(File.dirname(__FILE__))+"/seeds2.rb"