defmodule App do
  # map -> result int string
  def get_user_id_from_session(session) do
    if session == nil do
      {:error, "Session empty"}
    else
      {:ok, 42}
    end
  end

  # int -> result string string
  def get_photo_path_from_db(id) do
    if id == 42 do
      {:ok, "photo.png"}
    else
      {:error, "No such id"}
    end
  end

  # map -> result string string
  def get_user_name(session) do
    with {:ok, user_id} <- get_user_id_from_session(session),
         {:ok, photo_path} <- get_photo_path_from_db(user_id) do
      File.read(photo_path)
    end
  end
end

IO.inspect App.get_user_name(%{})
IO.inspect App.get_user_name(nil)


# TODO:
#
# konstruktor typu: result a e
#
# return1: a -> result a e
# return2: e -> result a e
#
# bind: result a e , (a -> result b e) -> result b e
