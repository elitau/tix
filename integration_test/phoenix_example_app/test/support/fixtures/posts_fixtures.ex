defmodule PhoenixExampleApp.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixExampleApp.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> PhoenixExampleApp.Posts.create_post()

    post
  end
end
