class String
  # Recursive gsub. Repeats till anything replaced.
  def gsub_r(pattern, sub)
    res = gsub(pattern, sub)
    res == self ? res : res.gsub_r(pattern, sub)
  end
end

class MatchData
  def at(i); self[i] end
end
