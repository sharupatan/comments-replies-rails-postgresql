class Api::V1::UserFollowersController < ApplicationController
    def index
        if params[:type] == "followers"
            user = UserFollower.where(followers_id: params[:followers_id])
            render json: user, each_serializer: UserFollowerIndexSerializer
        elsif params[:type] == "following"
            user = UserFollower.where(following_id: params[:following_id])
            render json: user, each_serializer: UserFollowerIndexSerializer
        else
            all = UserFollower.all
            render json: all, each_serializer: UserFollowerIndexSerializer
        end
    end

    def create
        user_follower = UserFollower.new(user_follower_params)
        if user_follower.save
            render json: user_follower, staus: :created
        else
            render json: user_follower.errors, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    end

    def destroy
        # take ids from the params
        user_follower = UserFollower.find_by(followers_id: params[:followers_id], following_id: params[:following_id])
        if user_follower
            if user_follower.destroy
                render json: { message: 'Unfollowed successfully' }, status: :ok
            else
                render json: user_follower.errors, status: :unprocessable_entity
            end                
        else
            render json: { error: 'User not found' }, status: :unprocessable_entity
        end
    end

    private

    def user_follower_params
        params.require(:user_follower).permit(:followers_id, :following_id)
    end
end
