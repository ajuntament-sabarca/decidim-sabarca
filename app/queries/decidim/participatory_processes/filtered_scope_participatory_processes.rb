# frozen_string_literal: true

module Decidim
  module ParticipatoryProcesses
    # This query class filters participatory processes given a filter name.
    # It uses the start and end dates to select the correct processes.
    class FilteredScopeParticipatoryProcesses < Rectify::Query
      def initialize(decidim_scope_id, filter = "active")
        @filter = filter
        @decidim_scope_id = decidim_scope_id
      end

      def query
        processes = if @decidim_scope_id.zero?
                      Decidim::ParticipatoryProcess.all
                    else
                      Decidim::ParticipatoryProcess.where(decidim_scope_id: @decidim_scope_id)
                    end
        case @filter
        when "past"
          processes.where("decidim_participatory_processes.end_date <= ?", Time.current)
        when "upcoming"
          processes.where("decidim_participatory_processes.start_date > ?", Time.current)
        else
          processes
        end
      end
    end
  end
end
