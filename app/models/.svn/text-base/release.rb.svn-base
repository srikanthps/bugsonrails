class Release < ActiveRecord::Base
   validates_presence_of :release_number, :release_date
   has_many :bugs

   def self.active_releases
     Release.all(:order => "release_number", :conditions => ["release_date >= :release_date", { :release_date => Time.now }])
   end

   def release_info
     date_format = "%d %b"
     date_format = "%d %b %Y" if release_date.year != Time.now.year
     "#{release_number} (#{release_date.strftime(date_format)})"
   end
end
