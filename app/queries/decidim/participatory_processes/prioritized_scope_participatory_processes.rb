# frozen_string_literal: true

module Decidim
  module ParticipatoryProcesses
    # This query orders processes by importance, prioritizing promoted processes
    # first, and closest to finalization date second.
    class PrioritizedScopeParticipatoryProcesses < Rectify::Query
      def query
        Decidim::ParticipatoryProcess
          .where(decidim_scope_id: @decidim_scope_id)
          .order(promoted: :desc).includes(:active_step)
          .order("decidim_participatory_process_steps.end_date ASC")
      end
    end
  end
end
