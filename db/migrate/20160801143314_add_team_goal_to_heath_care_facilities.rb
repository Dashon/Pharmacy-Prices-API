class AddTeamGoalToHeathCareFacilities < ActiveRecord::Migration
  def change
    add_column :health_care_facilities, :team_goal, :integer
  end
end
