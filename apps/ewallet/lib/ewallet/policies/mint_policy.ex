defmodule EWallet.MintPolicy do
  @moduledoc """
  The authorization policy for mints.
  """
  @behaviour Bodyguard.Policy
  alias EWalletDB.{Account, User}

  def authorize(:all, _user_or_key, _category_id), do: true

  def authorize(_, %{key: key}, _category_id) do
    Account.get_master_account().uuid == key.account.uuid
  end

  def authorize(_, %{admin_user: user}, _category_id) do
    User.master_admin?(user.id)
  end

  def authorize(_, _, _), do: false
end
