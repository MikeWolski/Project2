import { CardHeader } from '@mui/material';

export const Title = ({title, subheader, ...props}) => {
    return (
        <CardHeader title={title} subheader={subheader} {...props}/>
    );
}