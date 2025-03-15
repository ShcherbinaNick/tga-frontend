import React from 'react';
import logo2 from '../../assets/images/logo2.png';
import teleIcon from '../../assets/images/icons-telephone.png';
import emailIcon from '../../assets/images/icons-email.png';
import { Link } from 'react-router-dom';

const Header = () => {
  return (
    <header className='header'>
      <Link to='/'>
      <img src={logo2} alt='логотип DSA' className='header__logo' />
      </Link>
      <div className='header__info'>
        <h1 className='header__title'>ТОО "DSA Engineering Group"</h1>
        <div className='header__about'>
          <Link to='tel:+77272924911' className='header__links'>
            <img src={teleIcon}  className='header__links-icon' />
            +7(727)2924911
          </Link>
          <Link to='mailto:dsa.kaz@mail.ru' className='header__links'>
            <img src={emailIcon} className='header__links-icon' />
            dsa.kaz@mail.ru
          </Link>
          <Link to='/About' className='header__links'>
            О нас
          </Link>
        </div>
      </div>
    </header>
  );
};

export default Header;
