import React, { useEffect } from 'react';

const Carousel = ({ sliderData }) => {
  const [current, setCurrent] = React.useState(0);
  const [autoPlay, setAutoPlay] = React.useState(true);

  let timeOut = null;

  useEffect(() => {
    timeOut =
      autoPlay &&
      setTimeout(() => {
        slideRight();
      }, 2500);
  });

  const slideRight = () => {
    setCurrent(current === sliderData.length - 1 ? 0 : current + 1);
  };
  const slideLeft = () => {
    setCurrent(current === 0 ? sliderData.length - 1 : current - 1);
  };

  return (
    <div
      className='carousel'
      onMouseEnter={() => {
        setAutoPlay(false);
        clearTimeout(timeOut);
      }}
      onMouseLeave={() => setAutoPlay(true)}
    >
      <div className='carousel__wrapper'>
        {sliderData.map((image, index) => {
          return (
            <div
              key={index}
              className={
                index === current
                  ? 'carousel__card carousel__card_active'
                  : 'carousel__card'
              }
            >
              <img className='card__image' src={image.imageUrl} />
              <div className='card__overlay'>
                <h2 className='card__title'>{image.title}</h2>
              </div>
            </div>
          );
        })}
        <div className='carousel__arrow-left' onClick={slideLeft}>
          &lsaquo;
        </div>
        <div className='carousel__arrow-right' onClick={slideRight}>
          &rsaquo;
        </div>
        <div className='carousel__pagination'>
          {sliderData.map((_, index) => {
            return (
              <div
                key={index}
                className={
                  index === current
                    ? 'pagination__dot pagination__dot_active'
                    : 'pagination__dot'
                }
                onClick={() => setCurrent(index)}
              ></div>
            );
          })}
        </div>
      </div>
    </div>
  );
};

export default Carousel;
