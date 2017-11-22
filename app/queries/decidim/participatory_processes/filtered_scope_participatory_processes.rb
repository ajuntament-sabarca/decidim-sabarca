# frozen_string_literal: true

module Decidim
  module ParticipatoryProcesses
    # This query class filters participatory processes given a filter name.
    # It uses the start and end dates to select the correct processes.
    class FilteredScopeParticipatoryProcesses < Rectify::Query
      def initialize(filter = "active", decidim_scope_id)
        @filter = filter
        @decidim_scope_id = decidim_scope_id
      end

      def query
        if @decidim_scope_id== 0
          processes = Decidim::ParticipatoryProcess.all
        else
          processes = Decidim::ParticipatoryProcess.where(decidim_scope_id: @decidim_scope_id)
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
