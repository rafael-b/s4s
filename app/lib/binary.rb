class Binary

  def self.show_flags(flags,width=8)
    s  = "<span class='binary_flags'>"
    s += "[<span class='graphical'>#{flags.to_s(2).rjust(width,'0').gsub('0','.').gsub('1',"<span class='one'>x</span>")}</span>]"
    s += "[<span class='binary'>#{flags.to_s(2).rjust(width,'0')}</span>]"
    s += "(<span class='decimal'>#{flags}</span>)"
    s += '</span>'
    return s
  end

end