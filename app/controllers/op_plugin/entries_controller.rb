module OpPlugin
  class EntriesController < ApplicationController
    before_action :find_project
    before_action :authorize

    def index
      @entries = []
    end

    private

    def find_project
      @project = Project.find(params[:project_id])
    end
  end
end
