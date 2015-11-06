module ApplicationHelper

  def ugly_lyrics(lyrics)
    # new_lyrics = lyrics.split("/n")
    final_string = ""
    lyrics.lines.each do |line|
      final_string << "&#9835; #{h(line)}"
    end
    final_lyric = "<pre>#{final_string}</pre>"
    final_lyric.html_safe
  end

end
