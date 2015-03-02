namespace :pm do

  desc "Generate random projects and tasks"
  
  task :g_random => :environment do

    5.times do
      p = Project.create(title: Faker::Company.bs, description: Faker::Lorem.sentence, user: User.last)
      5.times do
        p.tasks.create(title: Faker::Company.bs, user: User.last)
      end
    end
  end
  
  desc "Generate a summary (list) of all newly created tasks that that day for projects"
     
  task :list_tasks => :environment do
    puts "Here's today's task list"
    Project.all.each do |p|
      @project = p
      p.tasks.all.each do |t|
        t_date = t.created_at.to_time
        today = Date.today.to_time
        @condition = t_date.day == today.day && t_date.month == today.month && t_date.year == today.year        
        #theres probably a much better way to do this condition
        if @condition   
          puts "# #{t.id} -Task Title: '#{ 
                t.title}' for # #{t.project.id} -Project: '#{t.project.title}'"      
        end
      end
    end
    if @condition
       User.all.each do |user|
        ProjectsMailer.notify_project_owner(user).deliver
      end
    end
    puts "   *To see full report, please check your mail" 
    puts "   *Remember, each user gets a seperate email, so check all your browser tabs"
    puts "    See you there friend"
  end 
  
  desc "Generate a summary (list) of all newly created discussions that that day for projects"
  
  task :list_discussions => :environment do
    puts "Here's today's disscussion list"
    Project.all.each do |p|
      @project = p
      p.discussions.all.each do |d|
        d_date = d.created_at.to_time
        today = Date.today.to_time
        @condition = d_date.day == today.day && d_date.month == today.month && d_date.year == today.year        
        #theres probably a much better way to do this condition
        if @condition   
          puts "# #{d.id} -Discussion Title: '#{ 
                d.title}' for # #{d.project.id} -Project: '#{d.project.title}'"      
        end
      end
    end
    if @condition
      User.all.each do |user|
        ProjectsMailer.notify_project_owner(user).deliver
      end
    end
    puts "   *To see full report, please check your mail" 
    puts "   *Remember, each user gets a seperate email, so check all your browser tabs"
    puts "    See you there friend"
  end 
  
end
