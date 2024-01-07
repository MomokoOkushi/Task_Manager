module Admin::TasksHelper
  # コメントの自然言語処理のスコアによる条件分岐(タスク一覧)
  def task_has_negative_comments?(task)
    score = task_comments_score(task)
    return false unless score
    score < 0 && score >= -0.4
  end

  def task_has_more_negative_comments?(task)
    score = task_comments_score(task)
    return false unless score
    score < -0.4
  end

  def task_comments_score(task)
    task.comments.where.not(score: nil).pluck(:score).min
  end

  # タスク詳細の自然言語処理のスコアによる条件分岐
  def task_has_negative_word?(task)
    score = task.score
    return false unless score
    score < 0 && score >= -0.4
  end

  def task_has_more_negative_word?(task)
    score = task.score
    return false unless score
    score < -0.4
  end

  def comment_is_negative?(comment)
    score = comment.score
    return false unless score
    score < 0 && score >= -0.4
  end

  def comment_is_more_negative?(comment)
    score = comment.score
    return false unless score
    score < -0.4  end
end
