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


defmodule Result do
  def ok(a) do
    {:ok, a}
  end

  def error(e) do
    {:error, e}
  end

  # result a e , (a -> result b e) -> result b e
  def and_then({:ok, a}, f) do
    f.(a)
  end

  def and_then({:error, e}, _) do
    {:error, e}
  end
end

defmodule App2 do
  def get_user_id_from_session(session) do
    if session == nil do
      {:error, "Session empty"}
    else
      {:ok, 42}
    end
  end

  def get_photo_path_from_db(id) do
    if id == 42 do
      {:ok, "photo.png"}
    else
      {:error, "No such id"}
    end
  end

  def get_user_name(session) do
    get_user_id_from_session(session)
    |> Result.and_then(&get_photo_path_from_db/1)
    |> Result.and_then(&File.read/1)
  end
end

IO.inspect App2.get_user_name(%{})
IO.inspect App2.get_user_name(nil)
