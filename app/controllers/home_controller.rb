class HomeController < ApplicationController
  def index
  end

  def evaluate

    respond_to do |format|
      format.js {

        if session[:code]
          if params[:code]
            session[:code]=session[:code]+"\n"+params[:code]
          end
        else
          session[:code]=params[:code]
        end
        file = File.open('tmp/ruby.rb', 'w')
        file.syswrite(session[:code])
        file.close

        system('ruby tmp/ruby.rb > tmp/result.txt')
        byebug
        @result = File.read('tmp/result.txt')
        @code = params["code"]


      }

    end
  end

  def reset
    session[:code]=nil
    redirect_to '/'
  end
end
