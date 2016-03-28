module ConcurrentRubyHelpers
  def wait_for_async
    executor = Concurrent.global_io_executor
    until executor.completed_task_count == executor.scheduled_task_count
      sleep 0.1
    end
  end

  def run_in_event_loop
    yield
    wait_for_async
  end
end
