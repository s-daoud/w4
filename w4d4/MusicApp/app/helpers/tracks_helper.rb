module TracksHelper

  def ugly_lyrics(lyrics)
    lines = lyrics.split(". ")

    html = "<pre>"
    lines.each do |line|
      html += "&#9835; #{h(line)}<br>"
    end
    html += "</pre>"
    html.html_safe
  end
end
