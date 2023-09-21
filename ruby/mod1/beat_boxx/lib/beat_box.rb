class BeatBox
  attr_reader :list,
              :rate,
              :voice
  def initialize
    @list = LinkedList.new
    @approved = ["beep", "boop", "bap", "bip", "bep", "peep", "poop", "pap", "pip", "deep", "doo", "ditt", "woo", "hoo", "shu", "bop", "tee"]
    @rate = 200
    @voice = "Samantha"
  end

  def append(data)
    type = "append"
    append_prepend(type, data)
  end

  def prepend(data)
    type = "prepend"
    append_prepend(type, data)
  end

  def append_prepend(type, data)
    sounds(data).map do |sound|
      if @approved.include?(sound)
        case type
        when "append"
          @list.append(sound)
        when "prepend"
          @list.prepend(sound)
        end
      end
    end
  end

  def count
    @list.count
  end

  def play
    `say -r #{@rate} -v #{@voice} "#{@list.to_string}"`
  end

  def all
    @list.to_string
  end

  def sounds(data)
    data.split
  end

  def set_rate(rate)
    @rate = rate
  end

  def set_voice(voice)
    @voice = voice
  end
end