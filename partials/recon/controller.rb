def setup_recon_controller
  create_file "app/controllers/recon_controller.rb", <<~RUBY
    class ReconController < ApplicationController
      # allow_unauthenticated_access only: [:create]

      def create
        goal = params[:query] || params[:organization_name]
        if goal.blank?
          render json: { error: "Missing 'query' parameter" }, status: :bad_request
          return
        end

        goal += " located in \#{params[:location]}" if params[:location].present?
        goal += " domain: \#{params[:domain]}" if params[:domain].present?
        
        history = params[:history] || []

        # Use the ResearchAgent model
        agent = ResearchAgent.new(goal: goal, history: history)
        result = agent.perform

        status = result[:status] == "success" ? :ok : :unprocessable_entity
        render json: result, status: status
      end
    end
  RUBY

  route 'post "recon", to: "recon#create"'
end