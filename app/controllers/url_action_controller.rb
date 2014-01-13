require 'Base66'

class UrlActionController < ApplicationController
	protect_from_forgery :except => [:api]

	def shrink
		if session[:user_id].nil?
			@new_url = Url.new :target => params.require(:shrink)["target"]
			@new_url.save
			render text: @new_url.key
		else
			@params = {:target => params.require(:shrink)["target"], :user_id => session[:user_id]}
			@new_url = Url.new @params
			@new_url.save
			render text: @new_url.key
		end
	end

	def bookmarklet
		if !session[:user_id].nil?
			@params = {:target => URI.decode(params[:url]), :user_id => session[:user_id]}
			@new_url = Url.new @params
			@new_url.save
		end
		redirect_to user_home_path
	end

	def mass_shrink
		if !session[:user_id].nil?
			@val = params.permit(:urls)[:urls]
			@urls = Array.new
			@urls = @val.split("\n")
			if @urls.size <= 25
				@keys_array = Array.new
				@urls.each do |url|
					@params = {target: url, user_id: session[:user_id]}
					@new_url = Url.new @params
					@new_url.save
					@keys_array << @new_url.key
				end
				@render = "http://ily.io/" + @keys_array.join("\nhttp://ily.io/")
			else
				@render = "0"
			end
			render text: @render
		end
	end

	def multi_links_shrink
		@links = Nokogiri::HTML params.permit(:links)[:links]

		if @links.css("a").size <= 25
			@links.css("a").each do |link|
				@params = {target: link["href"], user_id: session[:user_id]}
				@new_url = Url.new @params
				@new_url.save
				link["href"] = "http://ily.io/" + @new_url.key
			end
			@render = @links.to_s.split("<html><body>\n")[1].split("\n</body></html>")[0]
		else
			@render = "0"
		end
		render text: @render
	end

	def api
		@user = User.find(params[:user_id].to_i)
		@api_key = @user.get_api_key
		if params[:api_key] == @api_key
			@url = "http://" + format_url(params[:url])
			@new_url = Url.new({target: @url, user_id: @user.id})
			@new_url.save
			@key = @new_url.key
			render text: "http://ily.io/"+@key
		else
			render text: "0"
		end
	end

	def test
		render text: <<-EOS
<head>
	<script src="assets/jquery-1.9.0.min.js"></script>
	<script>
		var ilyio_user_id = 2;
		var ilyio_delay = 5000;
		var ilyio_interval = 5;
		var ilyio_maximum = 5;
	</script>
	<script src="assets/wes.js"></script>
</head>
<body>
	Hello...
</body>
EOS
	end

	def destroy
		@id = params[:id]
		@url = Url.find(@id)
		if @url.user_id == session[:user_id]
			if @url.destroy
				render text: "1"
			else
				render text: "0"
			end
		end
	end

	def forward_to
		render text: params[:key]
	end

	def easy_link
		@to = format_url request.fullpath, params[:user_id]
		session[:easy_link_url] = @to
		@digest_to = Digest::MD5.hexdigest(@to)
		@user_id = "+"+params[:user_id].split("+")[0]
		redirect_to digest_easy_link_path(@user_id, @digest_to)
	end

	def digest_easy_link
		@url = session[:easy_link_url]
		#session.delete(:easy_link_url)
		render text: @url
	end

	def update_urls
		@new_urls = get_urls
		render layout: false
	end

	private
		def get_urls
			urls = Array.new
			urls = Url.where(:user_id => session[:user_id])
			new_urls = Array.new
			if urls.size > 0
				pages = 1..(urls.size / 10.0).ceil
				pages.each do |page|
					x = (page-1)*10
					array = Array.new
					if page == pages.end
						if urls.length % 10 == 0
							y = x + 9
						else
							y = x - 1 + (urls.length % 10)
						end
						(x..y).each do |i|
							array << urls[i]
						end
					else
						y = x + 9
						(x..y).each do |i|
							array << urls[i]
						end
					end
					new_urls << array
				end
			end
			new_urls
		end

		def format_url fullpath, user_id=""
			if user_id == ""
				user_id_size = 0
			else
				user_id_size = user_id.to_s.size + 2
			end

			if fullpath[user_id_size..user_id_size+7] == "https://"
				size = fullpath.size - 1
				fullpath[user_id_size+8..size]
			elsif fullpath[user_id_size..user_id_size+6] == "http://"
				size = fullpath.size - 1
				fullpath[user_id_size+7..size]
			elsif fullpath[user_id_size..user_id_size+6] == "https:/"
				size = fullpath.size - 1
				fullpath[user_id_size+7..size]
			elsif fullpath[user_id_size..user_id_size+5] == "http:/"
				size = fullpath.size - 1
				fullpath[user_id_size+6..size]
			else
				size = fullpath.size - 1
				fullpath[user_id_size..size]
			end
		end
end
