class Task < ApplicationRecord
   TaskStatuses = [["To do", "to_do"], ["Pending", "pending"], ["Completed", "completed"]]

    belongs_to :user

    validates :title, presence: true
    validates :status, presence: true
    validate :total_to_do_task_validation
    scope :fetch_tasks_by_status, ->(status, user_id) {where('status = ? AND user_id = ?', status, user_id)}
    scope :to_do_task, ->(user_id) { where('status = "to_do" AND user_id = ?', user_id) }

    def total_to_do_task_validation
        if status == "to_do" && (Task.to_do_task(user_id).count >= (user_tasks.count/2))
            self.errors.add(:base, "Already todo task are there to complete")
        end
    end

    def user_tasks
        @user_tasks ||= User.find(user_id).tasks
    end

end
