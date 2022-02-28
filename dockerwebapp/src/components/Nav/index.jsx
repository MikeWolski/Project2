import { AppBar, Grid, Toolbar, IconButton } from '@mui/material';
import MenuIcon from '@mui/icons-material/Menu'; 

const Nav = ({children, color='#000000', ...props}) => {
    return (
        <AppBar sx={{backgroundColor: color}}>
            <Toolbar>
                <Grid alignItems="center" {...props} container>
                    <IconButton>
                        <MenuIcon sx={{color: '#F78F20'}}/>
                    </IconButton>
                    {children}
                </Grid>
            </Toolbar>
        </AppBar>
    );
}

export default Nav;