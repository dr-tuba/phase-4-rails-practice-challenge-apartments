class TenantsController < ApplicationController
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActionController::UnpermittedParameters, with: :render_unpermitted_params_response

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end

    private

    def tenant_params
        params.permit(:name, :age, :id)
    end

    def render_not_found_response
        render json: { error: "Tenant not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def render_unpermitted_params_response
        render json: { "Unpermitted Parameters": params.to_unsafe_h.except(:controller, :action, :id, :name, :age)}, status: :unprocessable_entity
    end
end
