$(() => {
  ((exports) => {
    const $mayorNeighborhoodsGrid = $('#mayor-neighborhood-grid');
    const $loadingMayorNeighborhoods = $mayorNeighborhoodsGrid.find('.loading');
    const filterLinksSelector = '.order-by__tabs a'

    $loadingMayorNeighborhoods.hide();

    $mayorNeighborhoodsGrid.on('click', filterLinksSelector, (event) => {
      const $target = $(event.target);
      const $mayorNeighborhoodsGridCards = $mayorNeighborhoodsGrid.find('.card-grid .column');

      $(filterLinksSelector).removeClass('is-active');
      $target.addClass('is-active');

      $mayorNeighborhoodsGridCards.hide();
      $loadingMayorNeighborhoods.show();

      if (exports.history) {
        exports.history.pushState(null, null, $target.attr('href'));
      }
    });
  })(window);


});
