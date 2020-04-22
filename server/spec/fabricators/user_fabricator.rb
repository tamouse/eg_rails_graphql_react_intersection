Fabricator(:user) do
  handle                { sequence(:handle) { |seqno| "jill#{seqno}" } }
  email                 { sequence(:email)  { |seqno| "jill#{seqno}@ex.com" } }
  password              "pw"
  password_confirmation "pw"
end
