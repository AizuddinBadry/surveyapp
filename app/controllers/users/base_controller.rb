class Users::BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :populate_hash

    def populate_hash
        @trumbowyg_hash = Hash.new
        (1..18).each { |index| @trumbowyg_hash[index] = "free" }
    end
end
