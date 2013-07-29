class Api::CaloriesController < ApplicationController
    require 'nokogiri'
    skip_before_filter :verify_authenticity_token

    def search
        calories = Calorie.all
        respond_to do |format|
            format.json {render :json => create_json(calories) }
        end
    end


    def show
        task = Calorie.find_by_id(params[:id])
        (render_error(404, "resource not found") and return) unless task
        respond_to do |format|
            format.json {render :json => create_json(task) }
        end
    end

    def create
        (render_error(400, "missing name param") unless params[:name]) and return
        (render_error(400, "missing name param") unless params[:calorie]) and return
        task = Calorie.create({ :name => params[:name], :calorie => params[:calorie]})
        respond_to do |format|
            format.json {render :json => create_json(task), :status => 201 }
        end
    end

    def update
        task = Calorie.find_by_id(params[:id])
        render_error(404, "resource not found") and return unless task
        task.name = params[:name]
        task.body = params[:body]
        task.save!
        respond_to do |format|
            format.json { render :json => create_json(task)}
        end
    end

    def destory
        task = Calorie.find_by_id(params[:id])
        error_error(404, "resource not found") and return unless task
        task.delete
        head 200
    end

    private

    def create_json(calories)
        unless calories.respond_to? "inject" then
            calories = [calories]
        end

        calories = calories.inject([]){ |arr, calorie|
            arr << {
                :id => calorie.id,
                :name => calorie.name,
                :calorie => calorie.calorie,
                :created_at => calorie.created_at
            }

            arr
        }
        { :calories => calories }.to_json
    end
end
