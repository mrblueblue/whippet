defmodule Records do
  use Hound.Helpers

  def selected do
    visible_text({:css, ".count-selected"})
  end

  def all do
    visible_text({:css, ".count-all"})
  end

end
