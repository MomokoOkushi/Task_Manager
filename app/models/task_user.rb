class TaskUser < ApplicationRecord
    belongs_to :user
    belongs_to :task

    enum task_status: { before_starting: 0, started: 1, under_survay: 2, waiting_contacts: 3, waiting_confirmation: 4 }
end
