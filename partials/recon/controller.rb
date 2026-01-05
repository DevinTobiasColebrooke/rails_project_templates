def setup_recon_controller
  create_file "app/controllers/recon_controller.rb", <<~RUBY
    class ReconController < ApplicationController
      # allow_unauthenticated_access only: [:create] # Uncomment if using auth

      def create
        goal = params[:query] || params[:organization_name]

        if goal.blank?
          render json: { error: "Missing 'query' parameter" }, status: :bad_request
          return
        end

        # Append context if provided
        goal += " located in \#{params[:location]}" if params[:location].present?
        goal += " domain: \#{params[:domain]}" if params[:domain].present?

        # Accept history from the UI app (Array of { role: "...", content: "..." })
        history = params[:history] || []

        # Initialize Orchestrator with history
        orchestrator = Recon::AutonomousOrchestrator.new(goal, history: history)
        result = orchestrator.call

        status = result[:status] == "success" ? :ok : :unprocessable_entity
        render json: result, status: status
      end
    end
  RUBY

  route 'post "recon", to: "recon#create"'
end