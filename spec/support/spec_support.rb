module SpecSupport
  # ユニーク維持の為
  def timestamp!(timestamp = Time.now.to_i)
    @timestamp = timestamp
  end

  def timestamp
    @timestamp
  end

  def current_user
    @current_user
  end

  def log_in(user = create(:user), type: :request)
    @current_user = user

    case type
    when :request
      sign_in(user)
    when :system
      visit new_user_session_path
      find('#user_email').set(user.email)
      find('#user_password').set(user.password)
      first("input[value='Log in']").click
    end
  end

  def log_out
    sign_out(current_user)
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end

  # Domの読み込みが完了するまで待つメソッド
  def wait_until(wait_time = Capybara.default_max_wait_time)
    Timeout.timeout(wait_time) do
      loop until yield
    end
  end

  # 任意のタイミングのスクリーンショットを撮影するメソッド
  def take_screenshot
    page.save_screenshot(Rails.root.join('tmp', 'screenshots', "debug-#{Time.now.to_i}.png"))
  end
end
