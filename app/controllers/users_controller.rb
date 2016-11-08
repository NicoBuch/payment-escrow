class UsersController < ApplicationController

  def become_mediator
    current_user.update(mediator: true)
    redirect_to root_path
  end

  def public_keys
    byebug
  end
end
