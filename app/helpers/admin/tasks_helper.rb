module Admin::TasksHelper
  # コメントの自然言語処理のスコアによる条件分岐(タスク一覧にて使用)
  def task_has_negative_comments?(task) #感情分析スコアが-0.4以上０未満の時。タスク詳細画面にて使用
    score = task_comments_score(task)
    return false unless score
    score  >= -0.4 && score < 0
  end

  def task_has_more_negative_comments?(task) #感情分析スコアが-0.4より低い時。タスク詳細画面にて使用
    score = task_comments_score(task)
    return false unless score
    score < -0.4
  end

  def task_comments_score(task) #scoreが存在するかつ、存在するコメント全てのスコアの中で最小値を
    task.comments.where.not(score: nil).pluck(:score).min
  end

  # タスク詳細の自然言語処理のスコアによる条件分岐
  def task_has_negative_word?(task) #タスク本文にスコア0未満-0.4以上のものがあればtrueを返す。タスク一覧で使用。
    score = task.score
    return false unless score
    score  >= -0.4 && score < 0
  end

  def task_has_more_negative_word?(task) #タスク本文にスコア-0.4未満のものがあればtrueを返す。タスク一覧で使用。
    score = task.score
    return false unless score
    score < -0.4
  end

  def comment_is_negative?(comment)  #感情分析スコアが-0.4以上０未満の時。タスク詳細画面にて使用。
    score = comment.score
    return false unless score
    score  >= -0.4 && score < 0
  end

  def comment_is_more_negative?(comment) #感情分析スコアが-0.4より低い時。タスク詳細画面にて使用。
    score = comment.score
    return false unless score
    score < -0.4  
  end
end
