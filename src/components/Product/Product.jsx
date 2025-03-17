import React from 'react';

const Product = () => {
  return (
    <div className='product'>
      <img
        src='https://grozmer.ru/images/photos/article3891.jpg'
        className='product__img'
      />
      <div className='product__info'>
        <h2>Заголовок одного товара</h2>
        <p>Описание этого товара</p>
      </div>
    </div>
  );
};

export default Product;
