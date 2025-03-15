import React from 'react';
import { data } from '../../data';
import { Link, Route, Routes } from 'react-router-dom';
import Promo from '../Promo/Promo';

const Content = () => {
  return (
    <main className='content'>
      <Routes>
        <Route path='/' element={<Promo />} />
      </Routes>
      <p className='content__desc'>Мы предлагаем:</p>
      <ul className='content__grid'>
        {data.map((product, index) => {
          return (
            <li key={index} className='content__grid-item'>
              <Link to='product' className='content__item-link'>
                <img
                  className='content__grid-item-image'
                  src={product.imageUrl}
                  alt='изображение товара'
                />
                <h2 className='content__grid-item-title'>{product.title}</h2>
              </Link>
            </li>
          );
        })}
      </ul>
    </main>
  );
};

export default Content;
