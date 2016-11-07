class UsersController < ApplicationController

  def become_mediator
    current_user.update(mediator: true)
    redirect_to root_path
  end
end
