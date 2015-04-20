
namespace :cleanup do

task :kill_memberships_without_users => :environment do
  memberships = Membership.all
  memberships.each do |membership|
    if membership.user_id == nil
			membership.destroy
    end
  end
end

task :kill_memberships_without_projects => :environment do
  memberships = Membership.all
  memberships.each do |membership|
    if membership.project_id == nil
			membership.destroy
    end
  end
end

task :kill_tasks_without_projects => :environment do
  tasks = Task.all
  tasks.each do |task|
    if task.project_id == nil
			task.destroy
    end
  end
end

task :kill_comments_without_tasks => :environment do
  comments = Comment.all
  comments.each do |comment|
    if comment.task_id == nil
			comment.destroy
    end
  end
end

task :set_user_id_of_comments_without_users_to_nil => :environment do
  comments = Comment.all
  comments.each do |comment|
    unless User.exists?(id: comment.user_id)
			comment.user_id = nil
			comment.save
    end
  end
end

task :kill_tasks_with_null_project_id => :environment do
  tasks = Task.all
  tasks.each do |task|
    unless task.project_id != nil
			task.destroy
    end
  end
end

task :kill_comments_with_null_task_id => :environment do
  comments = Comment.all
  comments.each do |comment|
    unless comment.task_id != nil
			comment.destroy
    end
  end
end

task :kill_memberships_with_null_user_id_or_project_id => :environment do
  memberships = Membership.all
  memberships.each do |membership|
    if (membership.user_id != nil) || (membership.project_id != nil)
			membership.destroy
    end
  end
end


end
