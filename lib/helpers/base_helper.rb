# -*- encoding : utf-8 -*-

module BaseHelper

  def home_url
    config.home_url.dup
  end

  def charset_and_ie_support_tags
    wrap_whitespaces! <<-HTML.gsub!(/^\s*/, '').chomp!
      <meta charset="utf-8">
      <!--[if lt IE 9]><script src="/js/html5.min.js"></script><![endif]-->
    HTML
  end

  def meta_redirect_to
    if @params[:redirect][:path]
      wrap_whitespaces! <<-HTML.gsub!(/^\s*/, '').chomp!
        <meta http-equiv="refresh" content="0; url=#{@params[:redirect][:path]}">
        <script type="text/javascript">location.replace("#{home_url}#{@params[:redirect][:path]}");</script>
      HTML
    end
  end

  def meta_tags
    s = meta_redirect_to.to_s
    @params[:meta].each do |name, content|
      s << <<-HTML
        <meta name="#{name}" content="#{content}">
      HTML
    end
    s.chomp! || s
  end

  def stylesheet_link_tag
    '<link href="/css/app.min.css" rel="stylesheet">'
  end

  def javascript_include_tag
    '<script src="/js/app.js"></script>'
  end

  # Bang method coz it modify @_erbout directly.
  # For provide <%  %> without <%=  %>
  def remove_admin_bar!
    @_erbout << ucoz_injection('substr($ADMIN_BAR$, 0, 0)')
    nil
  end

  def vk_like_btn
    '<div id="vk_like" class="pull-left"></div>'
  end

  def vk_comments_box(uid)
    "<div class=\"VKborders\"><div id=\"vk_comments\" data-uid=\"#{uid}\"></div></div>"
  end
end
